From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 03 Jan 2009 08:43:59 +0000
Subject: Re: [PATCH] sparc: unify ipcbuf.h
Message-Id: <20090103084359.GA15773@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20081228200418.GA22991@uranus.ravnborg.org>
In-Reply-To: <20081228200418.GA22991@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, Jan 02, 2009 at 06:25:26PM -0800, David Miller wrote:
> From: Sam Ravnborg <sam@ravnborg.org>
> Date: Sun, 28 Dec 2008 21:04:18 +0100
> 
> > Looking closer the two structures only differed on the
> > size of __kernel_umode_t.
> > Add a sparc32 specific padding to cover this difference.
> > 
> > The other types had same size on sparc32 and sparc64.
> > 
> > Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> 
> I'm not sure this will work.
> 
> You've changed the size of the structure on 32-bit.
> 
> The last two "unused" members of ipc64_perm are "unsigned long long",
> not just plain "unsigned long" in the 32-bit variant.
> 
> But you've used plain "unsigned long" in the unified copy.

Good catch - this is obviously wrong.
I think I confused myself with the fact that
(sparc32)long long eqals to (sparc64)long
but not the other way around.

So the padding should be changed to long long which will do
the right thing on both sparc32 and sparc64.

I considered changing the padding to use __u64, __u16 etc,
but I could see that no other archicettures do so for their
ipcbuf definition.

No patch as I am waiting until you push out the updated sparc-next tree.
Or you can just fix it up yourself if you prefer.

	Sam

