From: Chris Newport <crn@netunix.com>
Date: Sun, 12 Aug 2007 19:23:35 +0000
Subject: Re: Sun4c interrupt controller - Sun4d relevance
Message-Id: <46BF5E37.7030707@netunix.com>
List-Id: <sparclinux.vger.kernel.org>
References: <46BF2A25.9090900@netunix.com>
In-Reply-To: <46BF2A25.9090900@netunix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Mark Fortescue wrote:

>
>>
>> This is VERY interesting as it should be possible to fix Sun4d by 
>> finding
>> the differences between sun4d and sun4m in Solaris and covering those 
>> points.
>>
>> This would almost certainly be easier than trying to fix the current 
>> mess. Unfortunately I am no longer able to do this but maybe someone 
>> will be interested enough to try. It might even be possible to fix 
>> pluto/fc but maybe that is too much to ask.
>>
>
> The code I found only explicitly supports sun4c, sun4m and sun4u. 
> Given this, you may find that it does not help. Check the sun web site 
> to find out which version of Solaris/SunOS was the last version with 
> sun4d support as this will help track down any source code. For sun4c 
> it was Solaris 2.7 but I did not find anything that looked like full 
> source code (for the sun4c specific elements) for Solaris 2.7.

Last Solaris support for sun4d was Solaris 2.8 so all of the code will 
be there in 2.6 somewhere. Maybe it is just a special case within sun4m 
with a few extra drivers, or maybe the code has not been released.
The SS1000 is frustratingly similar to the SS20, most of the devices are 
common.

ISTR that Sun4d was a joint venture with Cray, so some code might
be encumbered. I have not seen code so I can only guess.

