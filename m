From: Elena Reshetova <elena.reshetova@intel.com>
Date: Mon, 20 Feb 2017 11:06:17 +0000
Subject: [PATCH 0/4] arch subsystem refcounter conversions
Message-Id: <1487588781-15123-1-git-send-email-elena.reshetova@intel.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: linux-edac@vger.kernel.org, x86@kernel.org, sparclinux@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, peterz@infradead.org, gregkh@linuxfoundation.org, davem@davemloft.net, tglx@linutronix.de, mingo@redhat.com, tony.luck@intel.com, hpa@zytor.com, Elena Reshetova <elena.reshetova@intel.com>

Now when new refcount_t type and API are finally merged
(see include/linux/refcount.h), the following
patches convert various refcounters in the arch susystem from atomic_t
to refcount_t. By doing this we prevent intentional or accidental
underflows or overflows that can led to use-after-free vulnerabilities.

The below patches are fully independent and can be cherry-picked separately.
Since we convert all kernel subsystems in the same fashion, resulting
in about 300 patches, we have to group them for sending at least in some
fashion to be manageable. Please excuse the long cc list.

Elena Reshetova (4):
  s390: convert debug_info.ref_count from atomic_t to refcount_t
  x86: convert threshold_bank.cpus from atomic_t to refcount_t
  sparc: convert mdesc_handle.refcnt from atomic_t to refcount_t
  kvm: convert kvm.users_count from atomic_t to refcount_t

 arch/s390/include/asm/debug.h        |  3 ++-
 arch/s390/kernel/debug.c             |  8 ++++----
 arch/sparc/kernel/mdesc.c            | 17 +++++++++--------
 arch/x86/include/asm/amd_nb.h        |  3 ++-
 arch/x86/kernel/cpu/mcheck/mce_amd.c |  6 +++---
 include/linux/kvm_host.h             |  3 ++-
 virt/kvm/kvm_main.c                  |  8 ++++----
 7 files changed, 26 insertions(+), 22 deletions(-)

-- 
2.7.4

