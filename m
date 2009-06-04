From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 04 Jun 2009 18:11:12 +0000
Subject: Re: LEON SPARC git repository
Message-Id: <20090604181112.GA12167@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <4A27926C.5010501@gaisler.com>
In-Reply-To: <4A27926C.5010501@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

On Thu, Jun 04, 2009 at 11:22:52AM +0200, Kristoffer Glembo wrote:
> Hi,
>=20
> I have created a sparc-leon git repository on kernel.org. Currently the
> master branch is just a clone of sparc-next. There is a branch named
> experimental which contains our current patches:
>=20
> http://git.kernel.org/?p=3Dlinux/kernel/git/gaisler/sparc-leon.git;a=3Dlo=
g;h=3Dexperimental
>=20
> To start with it would be great to receive feedback on the patches
> against the SPARC architecture:
>=20
> http://git.kernel.org/?p=3Dlinux/kernel/git/gaisler/sparc-leon.git;a=3Dco=
mmitdiff;h=A45872c4e571b32ccde2acbecd2394b0fa152882
>=20
> Is it preferred that I post the patches directly to the list, instead of
> a link? The patchset against arch is ~2k lines. The patches against
> existing files is ~600 lines.

I suggest that you start with:
1) Initial posting that explains what leon is.
2) A serie of patches against existing files - logically splitted.

   Quickly browsing the link you gave tell me there is some stuff
   that needs to be redone.

When 2) is reviewed and agreed on continue with the leon specific stuff.
But do not expect much to be applied until the full set is reviewed.

You will obviously hit the fact that knowledgeable sparc people are
a scare resource so you must do everything you can to make it
easier for them to review your stuff.

Consider copying lkml on the patch set - there is more people there
that can give feedback.

	Sam
