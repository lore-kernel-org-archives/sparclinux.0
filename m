From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 05 Jun 2009 09:19:12 +0000
Subject: Re: LEON SPARC git repository
Message-Id: <20090605091912.GB19009@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <4A27926C.5010501@gaisler.com>
In-Reply-To: <4A27926C.5010501@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

On Fri, Jun 05, 2009 at 10:39:24AM +0200, Konrad Eisele wrote:
> Sam Ravnborg wrote:
> >On Thu, Jun 04, 2009 at 11:22:52AM +0200, Kristoffer Glembo wrote:
> >>Hi,
> >>
> >>I have created a sparc-leon git repository on kernel.org. Currently the
> >>master branch is just a clone of sparc-next. There is a branch named
> >>experimental which contains our current patches:
> >>
> >>http://git.kernel.org/?p=3Dlinux/kernel/git/gaisler/sparc-leon.git;a=3D=
log;h=3Dexperimental
> >>
> >>To start with it would be great to receive feedback on the patches
> >>against the SPARC architecture:
> >>
> >>http://git.kernel.org/?p=3Dlinux/kernel/git/gaisler/sparc-leon.git;a=3D=
commitdiff;h=A45872c4e571b32ccde2acbecd2394b0fa152882
> >>
> >>Is it preferred that I post the patches directly to the list, instead of
> >>a link? The patchset against arch is ~2k lines. The patches against
> >>existing files is ~600 lines.
> >
> >I suggest that you start with:
> >1) Initial posting that explains what leon is.
>=20
> Kristoffer sent a introduction to the mailing list on 06/01/2009. I appen=
ded
> the mail again at the end of this mail.
> Maybe to be added:
> The LEON processor was created by Jiri Gaisler who has risen to fame late=
ly=20
> by
> winning the Open Sparc Community award together with Martin Johansson .
> https://sun.systemnews.com/articles/127/4/news/20648
> They integrated the SPARC-T1 into the "GRLIB" framework. The sparc-LEON
> processor is one part of "GRLIB".
> The idea that might catch you is: when running linux on a FPGA
> programmed with a sparc-LEON design you run a system that is open source
> from the gate level upward.
> the sparc-LEON is distributed as GPL source and can be downloaded from
> www.gaisler.com.
>=20
> >2) A serie of patches against existing files - logically splitted.
>=20
> Already did this. As you will see in the listing below the existing
> file patches are marginal and easy to understand.

Hi Konrad.

If you want this reviewed then please do as asked and send a set of individ=
ual mails
each containing one logical change - with a description what it contains.
I (and others too) do not go hunting to find patches to review.

From the list below I can see you have a logical split of the changes.
So you just have to add the corresponding patch too.

If you did this before than document what was changed since then, which
review comments was addressed and especially which was not (and why).


> Therefore I guess it should be not so difficult to review these patches. =

> I'll explain
> the various parts here, for convenience I added a [ ] bracket so here
> I would suggest to enter:
>  [o] : obvious agreed
>  [+] : agreed
>  [?] : in question
>  [-] : rejected
>  [v] : rewrite
> left is for your opinion, right is my suggestion
>=20
> - arch/sparc/Kconfig:=20
> http://git.kernel.org/?p=3Dlinux/kernel/git/gaisler/sparc-leon.git;a=3Dco=
mmitdiff;h=A45872c4e571b32ccde2acbecd2394b0fa152882#patch1
>   diff.1: @@ -435,6 +435,33 @@
>   [ ][o] enable CONFIG_LEON option
>           This macro will shield, if undefined, all LEON specific code. I=
n=20
>           particular
>           include/asm/leon.h will get empty through #ifdef
>           arch/sparc/kernel/leon.c not compiled through=20
>           Makefile:obj-$(CONFIG_LEON)
>           arch/sparc/mm/leon.c not compiled through=20
>           Makefile:obj-$(CONFIG_LEON)

This is a good example why you should send the patches to the list.
It should be a matter of adding a comment telling you not to use "dafault n=
".
But now you force me to:
1) copy the link
2) paste it and open in in a browser
3) copy relevant source from browser
4) paste in in my mail client
5) then comment on it.

Had the patch been inlined I had saved 1) 2) 3) 4) and only had to delete a=
 few lines while
staying in my mail client.

So please inline patches - with good changelogs.

	Sam
