module aptos_framework::temp {
    use aptos_framework::event;

    friend aptos_framework::genesis;

    struct Data has key {
        inner: u64
    }

    #[event]
    struct NewData has store, drop {
        data: u64
    }

    public(friend) fun initialize(aptos_framework: &signer)  {
        move_to(aptos_framework, Data {
            inner: 0
        })
    }

    public entry fun heavy_calculation(iterations: u64) acquires Data {
        let data = borrow_global_mut<Data>(@aptos_framework);
        let new_data = data.inner + 1;
        data.inner = new_data;
        event::emit(NewData {
            data: new_data
        });

        let acc = 0;
        let i = 0;
        while (i < iterations) {
            acc = acc + i * 1;
            i = i + 1;
        };
    }
}
