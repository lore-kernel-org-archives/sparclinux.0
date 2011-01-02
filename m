From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 02 Jan 2011 15:53:29 +0000
Subject: Re: [PATCH v2 0/9] sparc: unify sparc/boot/piggyback
Message-Id: <20110102155329.GC21411@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20110101205701.GA4544@merkur.ravnborg.org>
In-Reply-To: <20110101205701.GA4544@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sat, Jan 01, 2011 at 09:57:01PM +0100, Sam Ravnborg wrote:
> I decided to complete the unification of piggyback.
> This was inspired by comments from Julian Calaby.
> 
> The patchset documents my findings while reverse engineering
> piggyback. And some limited refactoring also increased
> readability a lot.
> piggyback now takes an argument that tell if this is for
> sparc or sparc64 and uses this info to adjust behaviour
> as sparc and sparc64 differs in a few places.
> 
> With these additions we can now use the same piggyback for
> both sparc and sparc64.
> 
> My testing turned out that piggyback_64 was broken on my x86 box,
> because it was hardcoded to assume a big-endian host.
> I also found a few code-spots that assuemd the host was big-endian.
> All cases are fixed to be endian neutral.
> 
> Julian Calaby acknowledged that piggyback_64 had endian troubles.
> 
> This is boot tested on my sparc box.
> I have only build tested the sparc64 bits!
> 
> Since v1 of the patchset I have included 4 additional patches,
> the original 5 patches has not seen any updates.
> And the patches are properly numbered this time.

I have a v3 pending - so please do not apply this serie.
I will post it soon - awaiting any additional feedback.

Updates planned:
- addess Josip's comments
- redo changelog to document that we fix pggyback on little-endian host.

	Sam
