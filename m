From: David Miller <davem@davemloft.net>
Date: Thu, 05 Jan 2012 19:28:52 +0000
Subject: Re: SPARC32: forced setting of mode of SUN4M per-cpu timers
Message-Id: <20120105.142852.1964320141901441519.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1325727738.1385.3.camel@hp>
In-Reply-To: <1325727738.1385.3.camel@hp>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

From: Kirill Tkhai <tkhai@yandex.ru>
Date: Thu, 05 Jan 2012 17:52:09 +0400

>> In that case just always set the mode.
>> We prefer minimal ifdefs in the code.
>>
>> =A0=A0=A0=A0=A0=A0=A0=A0Sam
>=20
> Ok, #ifdef was removed
>=20
> ---

Please post patches you intend me to apply as fresh list postings,
rather than replies to other discussions.

Because of the way you posted this, it didn't get archived by our
patch management system at:

	http://patchwork.ozlabs.org/project/sparclinux/list/

In particular having two lines of "---" threw it off and made it
ignore your posting thinking it was not a patch at all.
