From: Christoph Hellwig <hch@lst.de>
Date: Mon, 05 May 2008 11:34:52 +0000
Subject: sys32_utimes
Message-Id: <20080505113452.GA2138@lst.de>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

shouldn't arch/sparc64/kernel/sys_sparc32.c:sys32_utimes() be removed in
favour of fs/compat.c:compat_sys_utimes()?  Looks like all other
architectures are using the latter one.
