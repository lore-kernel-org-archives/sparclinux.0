From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 28 Apr 2016 20:57:15 +0000
Subject: Re: Bisected: RED State Exception in 4.5 on E420R
Message-Id: <20160428205714.GA30251@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.20.1604061729350.16827@math.ut.ee>
In-Reply-To: <alpine.LRH.2.20.1604061729350.16827@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> 
> Do you know exactly when plain "ASSERT()" starts working and doesn't
> require the ". = " part?

I have digged a little. The original bug report is here:
http://marc.info/?l=linux-kbuild&m4930110427870&w=2

Here Jean report that is fails with binutils 2.14, and
Documentation/Changes list 2.12 as the minimum required version.

The bug will only manifest itself with a "plain" ASSERT.

So ASSERT placed inside:

SECTIONS
{
	.text TEXTSTART:
	{
	}

	ASSERT(bla bla, bla);
}

Will to my best understanding not trigger the bug.
x86 has a similar assert in line 186.

I did not test it - getting late here.

Will try to go through the .S files tomorrow to check
if I can find additional places where we can save
a few bytes.

And I may try to implment the above too.

	Sam
