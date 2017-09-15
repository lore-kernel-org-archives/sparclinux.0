From: Mark Rutland <mark.rutland@arm.com>
Date: Fri, 15 Sep 2017 21:51:48 +0000
Subject: Re: [PATCH v8 10/11] arm64/kasan: explicitly zero kasan shadow memory
Message-Id: <20170915215147.GA11849@remoulade>
List-Id: <sparclinux.vger.kernel.org>
References: <20170914223517.8242-1-pasha.tatashin@oracle.com>
 <20170914223517.8242-11-pasha.tatashin@oracle.com>
 <20170915011035.GA6936@remoulade>
 <c76f72fc-21ed-62d0-014e-8509c0374f96@oracle.com>
 <20170915203852.GA10749@remoulade>
 <bff836ec-3922-1783-6cb4-94d1be92544b@oracle.com>
In-Reply-To: <bff836ec-3922-1783-6cb4-94d1be92544b@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On Fri, Sep 15, 2017 at 05:20:59PM -0400, Pavel Tatashin wrote:
> Hi Mark,
>=20
> I had this option=C2=A0 back upto version 3, where zero flag was passed i=
nto
> vmemmap_alloc_block(), but I was asked to remove it, because it required =
too
> many changes in other places.

Ok. Sorry for bringing back a point that had already been covered.

> So, the current approach is cleaner, but the idea is that kasan should use
> its own version of vmemmap_populate() for both x86 and ARM, but I think i=
t is
> outside of the scope of this work.

I appreciate that this is unrelated to your ultimate goal, and that this is
somewhat frustrating given the KASAN code is arguably abusing the
vmemmap_populate() interface.

However, I do think we need to migrate the KASAN code to a proper interface
immediately, rather than making it worse in the interim.

> If you think I should add these function in this project, than sure I can
> send a new version with kasanmap_populate() functions.

I would very much appreciate if you could send a version with a
kasan_map_populate() interface. I'm more than happy to review/test that por=
tion
of the series, or to help if there's some problem which makes that difficul=
t.

Thanks,
Mark.
