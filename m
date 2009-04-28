From: David Miller <davem@davemloft.net>
Date: Tue, 28 Apr 2009 11:36:05 +0000
Subject: Re: SunFire V240 hangs
Message-Id: <20090428.043605.12757158.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20090408200711.GA1142@frankengul.org>
In-Reply-To: <20090408200711.GA1142@frankengul.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: seb@frankengul.org
Date: Mon, 27 Apr 2009 16:40:42 +0200

> I'm willing to downgrade for testing to check. Which one should I
> pick ? testing or stable ?

I built a kernel using tools that work for me, using your
provided config, and double checked that it boots on
my ultra45.  Give it a spin:

	http://vger.kernel.org/~davem/v240.image

it of course doesn't have the modules, and therfore won't
be able to mount root.  But we will see if it passes the
NMI test which is where you see problems.
