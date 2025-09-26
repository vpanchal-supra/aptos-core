// Copyright © Aptos Foundation
// Parts of the project are originally copyright © Meta Platforms, Inc.
// SPDX-License-Identifier: Apache-2.0

#![allow(clippy::arc_with_non_send_sync)]

use crate::account_universe::{AUTransactionGen, AccountUniverse};
use aptos_cached_packages::aptos_stdlib;
use aptos_proptest_helpers::Index;
use aptos_types::transaction::{ExecutionStatus, SignedTransaction, TransactionStatus};
use proptest::prelude::*;
use proptest_derive::Arbitrary;

#[derive(Arbitrary, Clone, Debug)]
pub struct TempHeavyCalculationGen {
    sender: Index,
}

impl AUTransactionGen for TempHeavyCalculationGen {
    fn apply(
        &self,
        universe: &mut AccountUniverse,
    ) -> (SignedTransaction, (TransactionStatus, u64)) {
        let sender = universe.pick(self.sender).1;

        let signed_transaction = sender
            .account()
            .transaction()
            .payload(aptos_stdlib::temp_heavy_calculation(100000))
            .sequence_number(sender.sequence_number)
            .gas_unit_price(100)
            .sign();

        let gas_used = 2000;
        let status = TransactionStatus::Keep(ExecutionStatus::Success);

        (signed_transaction, (status, gas_used))
    }
}
