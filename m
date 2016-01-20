From: Bryce <philip.copeland@oracle.com>
Date: Wed, 20 Jan 2016 17:40:14 +0000
Subject: Re: Minor tweak to silo regarding GPT labeled drives
Message-Id: <569FC67E.2040709@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <569D2C3E.5060608@oracle.com>
In-Reply-To: <569D2C3E.5060608@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 20/01/16 17:29, Sam Ravnborg wrote:
> On Mon, Jan 18, 2016 at 06:17:34PM +0000, Bryce wrote:
>> I've been prompted by a couple of folk to pass along this minor patch for silo
>> Newer sparc firmware, mostly in the T4 and above range, along with sun(vtoc) now
>> support gpt labelled drives on the system boot drive (and theoretically some can
>> also support msdos? not tried it)
>>
>> The problem with sillo is that it actively looks to see if a sun label magic is
>> written but GPT has no such 'magic' and silo would moan.
>>
>> Phil
>> =-->>
>>
>> >From 5d5994b88513f2e45701460d275a2d29ab89c40b Mon Sep 17 00:00:00 2001
>> From: Dazed and confused <clueless@somewhere.com>
> Can the original author be found and attributed?
>
> I recall davem would like silo patches to be signed off, like kernel patches.
>
> 	Sam
The original author is myself, that is the raw patch from the internal svn repo.


