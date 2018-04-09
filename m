From: Jerome Glisse <jglisse@redhat.com>
Date: Mon, 09 Apr 2018 14:53:56 +0000
Subject: Re: [PATCH 0/3] move __HAVE_ARCH_PTE_SPECIAL in Kconfig
Message-Id: <20180409145344.GA3285@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1523282229-20731-1-git-send-email-ldufour@linux.vnet.ibm.com>
 <20180409140721.GI21835@dhcp22.suse.cz>
In-Reply-To: <20180409140721.GI21835@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On Mon, Apr 09, 2018 at 04:07:21PM +0200, Michal Hocko wrote:
> On Mon 09-04-18 15:57:06, Laurent Dufour wrote:
> > The per architecture __HAVE_ARCH_PTE_SPECIAL is defined statically in t=
he
> > per architecture header files. This doesn't allow to make other
> > configuration dependent on it.
> >=20
> > This series is moving the __HAVE_ARCH_PTE_SPECIAL into the Kconfig file=
s,
> > setting it automatically when architectures was already setting it in
> > header file.
> >=20
> > There is no functional change introduced by this series.
>=20
> I would just fold all three patches into a single one. It is much easier
> to review that those selects are done properly when you can see that the
> define is set for the same architecture.
>=20
> In general, I like the patch. It is always quite painful to track per
> arch defines.

You can also add Reviewed-by: J=E9r=F4me Glisse <jglisse@redhat> my grep fu
showed no place that was forgotten.

Cheers,
J=E9r=F4me
