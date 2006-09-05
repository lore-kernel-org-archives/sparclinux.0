From: Rene Rebe <rene@exactcode.de>
Date: Tue, 05 Sep 2006 07:45:55 +0000
Subject: Re: TILO and others
Message-Id: <200609050945.55805.rene@exactcode.de>
List-Id: <sparclinux.vger.kernel.org>
References: <44FC960D.3040508@mydatex.cz>
In-Reply-To: <44FC960D.3040508@mydatex.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

On Monday 04 September 2006 23:09, Daniel Smolik wrote:
> Hi,
> have anybody tip how can I create bootable kernel image + ramdisk for
> SPARC. I tested TILO but haven't success.
>
> 			Thanks
> 				Dan

tilo did not work for me 5 weeks ago for a netboot image.

I used elftoaout + the piggyback helper in arch/sparc64.

Yours,

--=20
  Ren=E9 Rebe - ExactCODE - Berlin (Europe / Germany)
  http://exactcode.de | http://t2-project.org | http://rene.rebe.name
  +49 (0)30 / 255 897 45
