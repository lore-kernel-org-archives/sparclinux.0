From: David Miller <davem@davemloft.net>
Date: Sun, 30 Nov 2008 06:18:45 +0000
Subject: Re: sparc unification - step 4
Message-Id: <20081129.221845.262095282.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20081129220251.GA11354@uranus.ravnborg.org>
In-Reply-To: <20081129220251.GA11354@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 29 Nov 2008 23:02:51 +0100

> This is fourth set of patches unifying sparc/sparc64.
> They are done on top of sparc-next.
> 
> With this patchset arch/sparc64/Makefile is gone
> and what is left in sparc64 is only: lib/ kernel/ boot/
> 
> I have redone the previous "step-3" patchset as that took
> a very inelegant approach to the merging of the Makefile
> for sparc32 and sparc64. This time the set includes
> a few cleanup patches before the Makefile is merged.
> 
> Included is also a unification of vmlinux.lds.S.
> As the files was almost identical I took the time to do
> a real unification.
> 
> I have build tested for each step to avoid bisect
> issues. But I did not do a full rebuild so there is
> a small risk I missed something.
> 
> When applying this set and trying to do a sparc64 build
> kbuild will error out complaining about the asm symlink
> as we no longer uses a asm-sparc64 symlink.
> This is expected.
> 
> Patches generated using 'git format-patch -M -B' will
> follow (-M and -B makes the patch git specific but
> eases review).

This looks great, all applied.

I'll push this out to sparc-next-2.6 after I do a little bit
more build testing.

Thanks!
