
<a id="0x1_temp"></a>

# Module `0x1::temp`



-  [Resource `Data`](#0x1_temp_Data)
-  [Struct `NewData`](#0x1_temp_NewData)
-  [Function `initialize`](#0x1_temp_initialize)
-  [Function `heavy_calculation`](#0x1_temp_heavy_calculation)


<pre><code><b>use</b> <a href="event.md#0x1_event">0x1::event</a>;
</code></pre>



<a id="0x1_temp_Data"></a>

## Resource `Data`



<pre><code><b>struct</b> <a href="temp.md#0x1_temp_Data">Data</a> <b>has</b> key
</code></pre>



<details>
<summary>Fields</summary>


<dl>
<dt>
<code>inner: u64</code>
</dt>
<dd>

</dd>
</dl>


</details>

<a id="0x1_temp_NewData"></a>

## Struct `NewData`



<pre><code>#[<a href="event.md#0x1_event">event</a>]
<b>struct</b> <a href="temp.md#0x1_temp_NewData">NewData</a> <b>has</b> drop, store
</code></pre>



<details>
<summary>Fields</summary>


<dl>
<dt>
<code>data: u64</code>
</dt>
<dd>

</dd>
</dl>


</details>

<a id="0x1_temp_initialize"></a>

## Function `initialize`



<pre><code><b>public</b>(<b>friend</b>) <b>fun</b> <a href="temp.md#0x1_temp_initialize">initialize</a>(aptos_framework: &<a href="../../aptos-stdlib/../move-stdlib/doc/signer.md#0x1_signer">signer</a>)
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b>(<b>friend</b>) <b>fun</b> <a href="temp.md#0x1_temp_initialize">initialize</a>(aptos_framework: &<a href="../../aptos-stdlib/../move-stdlib/doc/signer.md#0x1_signer">signer</a>)  {
    <b>move_to</b>(aptos_framework, <a href="temp.md#0x1_temp_Data">Data</a> {
        inner: 0
    })
}
</code></pre>



</details>

<a id="0x1_temp_heavy_calculation"></a>

## Function `heavy_calculation`



<pre><code><b>public</b> entry <b>fun</b> <a href="temp.md#0x1_temp_heavy_calculation">heavy_calculation</a>(iterations: u64)
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> entry <b>fun</b> <a href="temp.md#0x1_temp_heavy_calculation">heavy_calculation</a>(iterations: u64) <b>acquires</b> <a href="temp.md#0x1_temp_Data">Data</a> {
    <b>let</b> data = <b>borrow_global_mut</b>&lt;<a href="temp.md#0x1_temp_Data">Data</a>&gt;(@aptos_framework);
    <b>let</b> new_data = data.inner + 1;
    data.inner = new_data;
    <a href="event.md#0x1_event_emit">event::emit</a>(<a href="temp.md#0x1_temp_NewData">NewData</a> {
        data: new_data
    });

    <b>let</b> acc = 0;
    <b>let</b> i = 0;
    <b>while</b> (i &lt; iterations) {
        acc = acc + i * 1;
        i = i + 1;
    };
}
</code></pre>



</details>


[move-book]: https://aptos.dev/move/book/SUMMARY
