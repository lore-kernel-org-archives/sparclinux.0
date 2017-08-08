From: Pasha Tatashin <pasha.tatashin@oracle.com>
Date: Tue, 08 Aug 2017 13:30:58 +0000
Subject: Re: [v6 11/15] arm64/kasan: explicitly zero kasan shadow memory
Message-Id: <43c261e5-7568-0d5b-70ab-d1f82ef257ec@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1502138329-123460-1-git-send-email-pasha.tatashin@oracle.com>
 <1502138329-123460-12-git-send-email-pasha.tatashin@oracle.com>
 <20170808090743.GA12887@arm.com>
 <f8b2b9ed-abf0-0c16-faa2-98b66dcbed78@oracle.com>
 <063D6719AE5E284EB5DD2968C1650D6DD004DA79@AcuExch.aculab.com>
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6DD004DA79@AcuExch.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 2017-08-08 09:15, David Laight wrote:
> From: Pasha Tatashin
>> Sent: 08 August 2017 12:49
>> Thank you for looking at this change. What you described was in my
>> previous iterations of this project.
>>
>> See for example here: https://lkml.org/lkml/2017/5/5/369
>>
>> I was asked to remove that flag, and only zero memory in place when
>> needed. Overall the current approach is better everywhere else in the
>> kernel, but it adds a little extra code to kasan initialization.
> 
> Perhaps you could #define the function prototype(s?) so that the flags
> are not passed unless it is a kasan build?
> 

Hi David,

Thank you for suggestion. I think a kasan specific vmemmap (what I 
described in the previous e-mail) would be a better solution over having 
different prototypes with different builds.  It would be cleaner to have 
all kasan specific code in one place.

Pasha
