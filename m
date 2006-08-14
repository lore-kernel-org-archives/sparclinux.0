From: David Miller <davem@davemloft.net>
Date: Mon, 14 Aug 2006 20:01:30 +0000
Subject: Re: sunffb dri/drm
Message-Id: <20060814.130130.95059482.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <44E097B9.8080301@exactcode.de>
In-Reply-To: <44E097B9.8080301@exactcode.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Rene Rebe <rene@exactcode.de>
Date: Mon, 14 Aug 2006 15:33:13 +0000

> I wonder if it is worth fixing it, given that it only accelerates lines 
> and the like and no texturing. It is likely of much use in modern 3D 
> applications.

It's not worthwhile because the X11 side has been totally disabled
when the sunffb X11 driver got rewritten in order to support Xrender
and other necessary 2D features.

The ability to use the 3D stuff is not likely to ever come back.

