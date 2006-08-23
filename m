From: David Miller <davem@davemloft.net>
Date: Wed, 23 Aug 2006 05:50:00 +0000
Subject: Re: sym53c8xx PCI card broken in 2.6.18
Message-Id: <20060822.225000.92584438.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <ec7cefb0608222059g48c36384keefedf8e19771cb7@mail.gmail.com>
	<20060822.210136.59470258.davem@davemloft.net>
	<ec7cefb0608222235p155b7ab0ld8a23d2db1fbe56d@mail.gmail.com>
In-Reply-To: <ec7cefb0608222235p155b7ab0ld8a23d2db1fbe56d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ebrower@gmail.com
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

From: "Eric Brower" <ebrower@gmail.com>
Date: Tue, 22 Aug 2006 22:35:14 -0700

> Would you consider assigning -1 to lenp (if provided) in
> of_find_property() when no matching device is found?

I think checking for NULL should be the first thing a caller of these
interfaces should do.  So from that perspective, I don't think putting
anything in *lenp makes sense.  It's value is undefined.

In fact since we'll leave *lenp alone if the property doesn't exist,
you can initialize it to -1 if you want to simplify your checks.
