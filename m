From: David Miller <davem@davemloft.net>
Date: Mon, 17 Aug 2009 21:26:20 +0000
Subject: Re: bug: spinlock on UP system
Message-Id: <20090817.142620.177206035.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <200908121736.31813.dennis@ausil.us>
In-Reply-To: <200908121736.31813.dennis@ausil.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Dennis Gilmore <dennis@ausil.us>
Date: Mon, 17 Aug 2009 16:13:51 -0500

> On Wednesday 12 August 2009 05:36:30 pm Dennis Gilmore wrote:
>> sorry for the crappy subject
>>
>> forgot to also add that we are now using dracut for the initrd
>>
>> it happens just after  usb initialisation
>>
>> Dennis
> 
> and it doesnt happen with 2.6.31-0.157.rc6.fc12.sparc64

Yes, this was a known problem in the networking fixes a week or
two ago.
