From: =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Date: Sat, 10 Nov 2018 18:58:29 +0000
Subject: [PATCH net-next 0/6] Remove VLAN.CFI overload
Message-Id: <cover.1541876179.git.mirq-linux@rere.qmqm.pl>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: netdev@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller" <davem@davemloft.net>, James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>, Paul Burton <paul.burton@mips.com>, Paul Mackerras <paulus@samba.org>, Ralf Baechle <ralf@linux-mips.org>, sparclinux@vger.kernel.org

Fix BPF code/JITs to allow for separate VLAN_PRESENT flag
storage and finally move the flag to separate storage in skbuff.

This is final step to make CLAN.CFI transparent to core Linux
networking stack.

An #ifdef is introduced temporarily to mark fragments masking
VLAN_TAG_PRESENT. This is removed altogether in the final patch.

---
Michał Mirosław (6):
  net/skbuff: add macros for VLAN_PRESENT bit
  net/bpf: split VLAN_PRESENT bit handling from VLAN_TCI
  net/bpf_jit: MIPS: split VLAN_PRESENT bit handling from VLAN_TCI
  net/bpf_jit: PPC: split VLAN_PRESENT bit handling from VLAN_TCI
  net/bpf_jit: SPARC: split VLAN_PRESENT bit handling from VLAN_TCI
  net: remove VLAN_TAG_PRESENT

 arch/mips/net/bpf_jit.c          | 18 ++++++++---------
 arch/powerpc/net/bpf_jit_comp.c  | 15 +++++++-------
 arch/sparc/net/bpf_jit_comp_32.c | 13 ++++++------
 include/linux/if_vlan.h          | 11 ++++++-----
 include/linux/skbuff.h           | 10 +++++++++-
 lib/test_bpf.c                   | 14 +++++++------
 net/core/filter.c                | 34 ++++++++++++++------------------
 7 files changed, 60 insertions(+), 55 deletions(-)

-- 
2.19.1
