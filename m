From: David Dillow <dave@thedillows.org>
Date: Sat, 07 Feb 2004 06:22:25 +0000
Subject: Re: AIO syscall patch, and problem
Message-Id: <1076134945.10346.44.camel@ori.thedillows.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1075876893.5035.60.camel@ori.thedillows.org>
In-Reply-To: <1075876893.5035.60.camel@ori.thedillows.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, 2004-02-06 at 22:36, David S. Miller wrote:
> On 04 Feb 2004 02:02:30 -0500
> David Dillow <dave@thedillows.org> wrote:
> 
> > The attached patch fixes a mis-numbering of the AIO syscalls under sparc
> > and sparc64.
> 
> The syscall tables were right, the header was wrong.  This patch below
> is the correct fix.  I don't know how the AIO tests passed for you
> with your posted patch, maybe nothing depends upon io_destroy() and
> subsequently numbered AIO syscalls doing anything :-)

Teaches me to redo a patch before sending it in.... I did the same thing
you did -- renumber to 272 -- and did all my testing (on sparc64) with
that. I redid the patch with the other numbering to be compatible with
sparc (and subsequently forgot about fixing up the table...) Doh!

And of course, I didn't test the one I sent -- it was trivial! I'll
blame the lure of sleep.... :)
