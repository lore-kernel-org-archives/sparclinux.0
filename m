From: Andrew Morton <akpm@osdl.org>
Date: Thu, 08 Apr 2004 20:16:56 +0000
Subject: Re: 2.6.5-mc2 switch_to() fix
Message-Id: <20040408131656.201807e2.akpm@osdl.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20040408122517.GD688@holomorphy.com>
In-Reply-To: <20040408122517.GD688@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

"David S. Miller" <davem@redhat.com> wrote:
>
> On Thu, 8 Apr 2004 12:03:05 -0700
> Andrew Morton <akpm@osdl.org> wrote:
> 
> > Probably it's Bill's patches which move the scheduler functions into their
> > own ELF section for wcahn identification purposes.
> 
> That's right, I saw those changes.
> 
> I think the best thing to do, therefore, is just to rearrange
> where that ELF section sits wrt. the main text in the sparc64
> vmlinux.lds file.


@@ -15,6 +15,7 @@ SECTIONS
   .text 0x0000000000404000 :
   {
     *(.text)
+    SCHED_TEXT
     *(.gnu.warning)
   } =0
   _etext = .;

Moving SCHED_TEXT to before .text should do it?
