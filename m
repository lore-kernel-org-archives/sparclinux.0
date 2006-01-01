From: kaffe <riccardo@kaffe.org>
Date: Sun, 01 Jan 2006 22:33:11 +0000
Subject: kernel compile problems on sparc32
Message-Id: <970C8856-7B16-11DA-940F-00050249ADE1@kaffe.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hello,

compiling latest gentoo kernel on sparc 32bit, 2.4.32, it didn't build. 
The fix is trivial and I was asked to report it here.

in arch/sparc32/math/math.c around lines 330 there are two #ifdef's 
with debugging outputs, they are in the default: section of a switch(), 
since if debug is disabled no statement exist, compilation will file.
My suggestion for a fix is simply to add

#ifdef ----
   --debug statement--
#else
    ;
#endif

I found two of these occurrences and I did not make a patch but just 
fixed my file, thus sorry for the "wordy" description.

Cheers,
    Riccardo

