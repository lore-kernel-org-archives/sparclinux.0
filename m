From: Frans van Berckel <fberckel@xs4all.nl>
Date: Sat, 31 Oct 2009 23:26:44 +0000
Subject: Re: temperature & fan-control
Message-Id: <1257031604.1994.11.camel@deblnxsrv254.opensoftwarenetwork.nl>
List-Id: <sparclinux.vger.kernel.org>
References: <1256288818.1858.15.camel@deblnxsrv254.opensoftwarenetwork.nl>
In-Reply-To: <1256288818.1858.15.camel@deblnxsrv254.opensoftwarenetwork.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

On Mon, 2009-10-26 at 16:12 +0100, Ra=C3=BAl Porcel wrote:

> Hi,
>=20
> maybe it was 2.6.27 the latest working? And no, i didn't file a bug,
> feel free to do it yourself.

Building kernels and found out so far, this does the bbc module well ...

linux-image-2.6.27.38-kernelbuilder_2.6.27.38-kernelbuilder=20

Nov  1 00:12:09 sunbladesrv249 kernel: [  119.998414] i2c-0: Regs at
000007fe7e00002e, 8 devices, own a0, clock 10.
Nov  1 00:12:09 sunbladesrv249 kernel: [  120.001615] i2c-1: Regs at
000007fe7e000030, 8 devices, own a0, clock 10.
Nov  1 00:12:09 sunbladesrv249 kernel: [  120.044808] bbc_envctrl:
kenvctrld starting...

but this one ... does not.=20

linux-image-2.6.28.10-kernelbuilder_2.6.28.10-kernelbuilder

A the strange thing is, .27 got newer patches then .28. Next is one of
the first .29.

Thanks,


Frans van Berckel

