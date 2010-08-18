From: David Miller <davem@davemloft.net>
Date: Wed, 18 Aug 2010 20:11:50 +0000
Subject: Re: XVR-600 console not working with e3d
Message-Id: <20100818.131150.71107545.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100817.144843.104046744.davem@davemloft.net>
In-Reply-To: <20100817.144843.104046744.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Josip Rodin <joy@entuzijast.net>
Date: Wed, 18 Aug 2010 11:32:25 +0200

> On Tue, Aug 17, 2010 at 02:48:43PM -0700, David Miller wrote:
>> From: Josip Rodin <joy@entuzijast.net>
>> Date: Tue, 17 Aug 2010 16:33:22 +0200
>> 
>> > OK, good. So our kernel still has something missing... I'm attaching the
>> > config in case anyone can spot anything obvious.
>> 
>> Config looks fine, the XVR500 driver will driver those chips.
>> 
>> Probably missing a patch to the driver or similar.
> 
> What's the revision of the file you built into xvr600_test.img,
> so that I can compare?

I have no idea, it was half a year ago.

Just compare drivers/video/sunxvr500.c in current mainline with
whatever is in your tree.
