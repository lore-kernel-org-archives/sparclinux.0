From: "Alexander Beregalov" <a.beregalov@gmail.com>
Date: Mon, 07 Jul 2008 15:59:04 +0000
Subject: Re: 2.6.26-rc: SPARC: Sun Ultra 10 can not boot
Message-Id: <a4423d670807070859y74f529b5i60f04e0a37a01cd3@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20080620.162135.203810660.davem@davemloft.net>
	 <a4423d670806201636n4f3d107bk290ed831eb5eefb4@mail.gmail.com>
	 <a4423d670807070219s2dd43aaia29713f5076ecd0d@mail.gmail.com>
	 <20080707.040126.178187777.davem@davemloft.net>
	 <18546.5247.797478.66373@harpo.it.uu.se>
In-Reply-To: <18546.5247.797478.66373@harpo.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: David Miller <davem@davemloft.net>, kernel-testers@vger.kernel.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

I have turned off LOCKDEP and it boots properly.
2.6.26-rc9-00005-g1b40a89

Mikael's config also does not contain LOCKDEP.
