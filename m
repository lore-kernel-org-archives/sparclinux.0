From: "David S. Miller" <davem@davemloft.net>
Date: Fri, 17 Mar 2006 08:40:30 +0000
Subject: Re: bbc, envctrl and sun blade 2000
Message-Id: <20060317.004030.65584653.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <87k6auqm68.fsf@thorr.asgardr.info>
In-Reply-To: <87k6auqm68.fsf@thorr.asgardr.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

From: Daniel 'NebuchadnezzaR' Dehennin <nebuchadnezzar@asgardr.info>
Date: Fri, 17 Mar 2006 07:38:17 +0100

> Le 4579 Septembre 1993, David S. Miller a tapot=E9:
> > The kernel only allows the module to be loaded on platforms where we
> > know the driver will work instead of erasing your hard disk.  And
> > currently the list of known and tested cases is SunBlade 1000.
>=20
> Ok, can I help to add SunBlade 2000 ?

Only if you can do the heavy lifting of building new kernels,
modifying the conditional, testing the result and sending
a working patch after the testing.

I simply don't have the time right now to do the hand holding, sorry.
