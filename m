From: Meelis Roos <mroos@linux.ee>
Date: Fri, 30 Jan 2004 17:39:52 +0000
Subject: Re: SILO 1.4.2 released
Message-Id: <Pine.GSO.4.44.0401301938310.2307-100000@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <20040129182954.GK532@phunnypharm.org>
In-Reply-To: <20040129182954.GK532@phunnypharm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

BC> I'm a little disappointed. I haven't gotten any feedback from people
BC> testing this new version. So either no one cares, or it works good and
BC> people don't want to waste their time sending "worked for me" emails :)

Fails here.

I upgraded my sparc32 unstable today (SS5-170, 256M RAM). It has some
2.4.21 kernel, probably the default debian kernel, as the default. With
your previous 1.4.1 Debian package, it booted fine. Now with SILO
Version 1.4.3, I get
Uncompressing image...
Loaded kernel version 2.4.21
Data Access Exception
ok

Tried also handcompiled 2.4.21+patches (also worked before) and old
2.2.20, still Data Access Exception.

I'm booting from disk1 if this matters (probably not).

Now to netbooting...

-- 
Meelis Roos (mroos@linux.ee)

