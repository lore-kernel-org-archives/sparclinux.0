From: "Ulrich Teichert" <Ulrich.Teichert@gmx.net>
Date: Sun, 12 Aug 2007 18:52:04 +0000
Subject: Re: Ultra 2 with nvram problems
Message-Id: <20070812185204.221180@gmx.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20070802220327.20940@gmx.net>
In-Reply-To: <20070802220327.20940@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Hi,

>Take a look at http://www.squirrel.com/sun-*nvram*-hostid.*faq*.html
>
>You need to buy a replacement chip and program it as per the FAQ.

Just for reference: it worked beautifully. If anyone ever will get into
the same situation with an Ultra-2, the above FAQ works well, even though
the machine isn't explicitly listed. You don't have to care about the
machine type, that's set during set-defaults or hard-wired.

Oh, and on my old NVRAM chip, the last 3 bytes of the ethernet address
were printed on top of it, just below the barcode. This happens to
be the last three bytes of the hostid as well, I think.

Thanks to all,
Uli
(Anyone need a spare NVRAM chip in Germany? I bought a pair of them, because
this was the only available package size ;-)
--=20
Ulrich Teichert
Stormweg 24
24539 Neum=FCnster, Germany


Psssst! Schon vom neuen GMX MultiMessenger geh=F6rt?
Der kanns mit allen: http://www.gmx.net/de/go/multimessenger
