From: Richard Mortimer <richm@oldelvet.org.uk>
Date: Tue, 03 Jan 2006 21:52:07 +0000
Subject: Re: SILO 1.4.10
Message-Id: <1136325128.9950.79.camel@duncow>
List-Id: <sparclinux.vger.kernel.org>
References: <1136175018.27583.50.camel@grayson>
In-Reply-To: <1136175018.27583.50.camel@grayson>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, 2006-01-03 at 12:50 -0800, David S. Miller wrote:
> From: Jim Gifford <maillist@jg555.com>
> Date: Tue, 03 Jan 2006 09:39:19 -0800
> 
> > So we have 2 potential issues
> > 
> > 1 - elftoaout is not creating proper files when it's compiled as 64bit
> > 2 - second.b is not being created properly
> 
> It's probably just some 64-bit arithmatic coding error
> in elftoaout that only gets triggered by the second.b
> image and not by most other uses of the utility.
> 

I just took at quick look at the Debian elftoaout sources and the a.out
Exec header definition uses unsigned long to hold the values. These will
have the wrong size when compiled 64 bit. I tried changing it to
unsigned int and the 64 bit version now produces the same output as the
32 bit one when tested against a vmlinux that I had hanging around.

Patch below.

Richard

--- sparc-utils-1.9/elftoaout-2.3/elftoaout.c.orig      2006-01-03 21:11:05.000000000 +0000
+++ sparc-utils-1.9/elftoaout-2.3/elftoaout.c   2006-01-03 21:16:20.000000000 +0000
@@ -37,14 +37,14 @@
 #define        CMAGIC      0x01030108

 typedef struct {
-       unsigned long   a_magic;        /* magic number */
-       unsigned long   a_text;         /* size of text segment */
-       unsigned long   a_data;         /* size of initialized data */
-       unsigned long   a_bss;          /* size of uninitialized data */
-       unsigned long   a_syms;         /* size of symbol table || checksum */
-       unsigned long   a_entry;        /* entry point */
-       unsigned long   a_trsize;       /* size of text relocation */
-       unsigned long   a_drsize;       /* size of data relocation */
+       unsigned int    a_magic;        /* magic number */
+       unsigned int    a_text;         /* size of text segment */
+       unsigned int    a_data;         /* size of initialized data */
+       unsigned int    a_bss;          /* size of uninitialized data */
+       unsigned int    a_syms;         /* size of symbol table || checksum */
+       unsigned int    a_entry;        /* entry point */
+       unsigned int    a_trsize;       /* size of text relocation */
+       unsigned int    a_drsize;       /* size of data relocation */
 } Exec;





-- 
Richard Mortimer <richm@oldelvet.org.uk>

