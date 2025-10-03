module aptos_framework::temp {
    use aptos_framework::event;
    use aptos_framework::block;

    friend aptos_framework::genesis;


    struct Observability has key {
        counter: u64
    }

    struct Data has key {
        inner: u64
    }

    #[event]
    struct NewObservability has store, drop {
        counter: u64
    }

    #[event]
    struct NewData has store, drop {
        data: u64
    }


    const MAX_JUMP: u64 = 10;
    const MAX_ACC_PUSHER: u64 = 2;

    
    fun init_module(signer: &signer) {
        move_to(signer, Data {
            inner: 0
        });
        move_to(signer, Observability {
            counter: 0
        })
    }

    public entry fun heavy_calculation(iterations: u64) acquires Observability, Data {
        let observability = borrow_global_mut<Observability>(@temp_package);
        let counter = observability.counter + 1;
        observability.counter = counter;
        event::emit(NewObservability {
            counter
        });

        let current_block_height = block::get_current_block_height();
        let acc = 0;
        let i = 0;
        let jump = (current_block_height % MAX_JUMP) + 1;
        let acc_pusher = (current_block_height % MAX_ACC_PUSHER) + 1;
        while (i < iterations) {
            acc = acc + jump * acc_pusher;
            i = i + 1;
        };

        let data = borrow_global_mut<Data>(@temp_package);
        data.inner = acc;
        event::emit(NewData {
            data: acc
        });
    }
}
