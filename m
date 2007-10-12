From: David Miller <davem@davemloft.net>
Date: Fri, 12 Oct 2007 08:37:27 +0000
Subject: Re: sun4v_data_access_exception on new 2.6.23
Message-Id: <20071012.013727.85409266.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <470E6F28.2010709@systella.fr>
In-Reply-To: <470E6F28.2010709@systella.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

From: BERTRAND_Jo=EBl <joel.bertrand@systella.fr>
Date: Fri, 12 Oct 2007 09:04:16 +0200

> 	I have rebuild a 2.6.23 kernel with gcc-4.1. When I try to format=20
> (ext3fs) a raid5 volume, I _allways_ obtain (I have tested four times):

That's a different bug which I will try to look into.

At least confirm that the other problem no longer occurs
as that's all I'm interested in at this point.
