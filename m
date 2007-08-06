From: Andrew Walrond <andrew@walrond.org>
Date: Mon, 06 Aug 2007 17:53:14 +0000
Subject: GCC 4.2.1 produces broken 2.6.22.1 kernel.
Message-Id: <46B7600A.3060700@walrond.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Andrew Walrond wrote:
> 
> I've got a horrible feeling I've just spent a day fighting against a
> miscompilation by gcc-4.2.
> 
> Perhaps this is a known problem? I'm rebuilding with gcc-4.1.2 now and
> will report back shortly....
> 

Confirmed; GCC 4.2.1 (vanilla) produces a broken 2.6.22.1 kernel. I
don't know why, or whether GCC or the kernel is at fault, but the exact
same kernel and config builds and boots fine with GCC 4.1.2.

This is on a Sun T1000 niagra box. Anything I can do? let me know.

Andrew Walrond
