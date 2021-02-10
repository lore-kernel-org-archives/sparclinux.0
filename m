From: Lorenz Bauer <lmb@cloudflare.com>
Date: Wed, 10 Feb 2021 12:04:21 +0000
Subject: [PATCH bpf 0/4] Expose network namespace cookies to user space
Message-Id: <20210210120425.53438-1-lmb@cloudflare.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Cc: kernel-team@cloudflare.com, Lorenz Bauer <lmb@cloudflare.com>, bpf@vger.kernel.org, linux-alpha@vger.kernel.org, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, netdev@vger.kernel.org, sparclinux@vger.kernel.org

We're working on a user space control plane for the BPF sk_lookup
hook [1]. The hook attaches to a network namespace and allows
control over which socket receives a new connection / packet.

Roughly, applications can give a socket to our user space component
to participate in custom bind semantics. This creates an edge case
where  an application can provide us with a socket that lives in
a different network namespace than our BPF sk_lookup program.
We'd like to return an error in this case.

Additionally, we have some user space state that is tied to the
network namespace. We currently use the inode of the nsfs entry
in a directory name, but this is suffers from inode reuse.

I'm proposing to fix both of these issues by adding a new
SO_NETNS_COOKIE socket option as well as a NS_GET_COOKIE ioctl.
Using these we get a stable, unique identifier for a network
namespace and check whether a socket belongs to the "correct"
namespace.

NS_GET_COOKIE could be renamed to NS_GET_NET_COOKIE. I kept the
name generic because it seems like other namespace types could
benefit from a cookie as well.

I'm trying to land this via the bpf tree since this is where the
netns cookie originated, please let me know if this isn't
appropriate.

1: https://www.kernel.org/doc/html/latest/bpf/prog_sk_lookup.html

Cc: bpf@vger.kernel.org
Cc: linux-alpha@vger.kernel.org
Cc: linux-api@vger.kernel.org
Cc: linux-arch@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
Cc: linux-mips@vger.kernel.org
Cc: linux-parisc@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: sparclinux@vger.kernel.org

Lorenz Bauer (4):
  net: add SO_NETNS_COOKIE socket option
  nsfs: add an ioctl to discover the network namespace cookie
  tools/testing: add test for NS_GET_COOKIE
  tools/testing: add a selftest for SO_NETNS_COOKIE

 arch/alpha/include/uapi/asm/socket.h          |  2 +
 arch/mips/include/uapi/asm/socket.h           |  2 +
 arch/parisc/include/uapi/asm/socket.h         |  2 +
 arch/sparc/include/uapi/asm/socket.h          |  2 +
 fs/nsfs.c                                     |  9 +++
 include/linux/sock_diag.h                     | 20 ++++++
 include/net/net_namespace.h                   | 11 ++++
 include/uapi/asm-generic/socket.h             |  2 +
 include/uapi/linux/nsfs.h                     |  2 +
 net/core/filter.c                             |  9 ++-
 net/core/sock.c                               |  7 +++
 tools/testing/selftests/net/.gitignore        |  1 +
 tools/testing/selftests/net/Makefile          |  2 +-
 tools/testing/selftests/net/so_netns_cookie.c | 61 +++++++++++++++++++
 tools/testing/selftests/nsfs/.gitignore       |  1 +
 tools/testing/selftests/nsfs/Makefile         |  2 +-
 tools/testing/selftests/nsfs/netns.c          | 57 +++++++++++++++++
 17 files changed, 185 insertions(+), 7 deletions(-)
 create mode 100644 tools/testing/selftests/net/so_netns_cookie.c
 create mode 100644 tools/testing/selftests/nsfs/netns.c

-- 
2.27.0
