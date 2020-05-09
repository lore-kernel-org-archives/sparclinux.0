From: Chen Zhou <chenzhou10@huawei.com>
Date: Sat, 09 May 2020 09:18:47 +0000
Subject: [PATCH -next 0/2] sparc: use snprintf() in show() methods
Message-Id: <20200509091849.116954-1-chenzhou10@huawei.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, chenzhou10@huawei.com

snprintf() returns the number of bytes that would be written,
which may be greater than the the actual length to be written.
	    
show() methods should return the number of bytes printed into the
buffer. This is the return value of scnprintf().

Chen Zhou (2):
  sparc: use snprintf() in show_pciobppath_attr() in pci.c
  sparc: use snprintf() in show_pciobppath_attr() in vio.c

 arch/sparc/kernel/pci.c | 2 +-
 arch/sparc/kernel/vio.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.20.1
