From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 05 Apr 2012 07:26:21 +0000
Subject: Re: sparc - generic clock event support
Message-Id: <20120405072621.GA17477@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20120404200704.GA16958@merkur.ravnborg.org>
In-Reply-To: <20120404200704.GA16958@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, Apr 05, 2012 at 08:55:21AM +0200, Konrad Eisele wrote:
> Sam Ravnborg wrote:
>> I have now finised revising the patch to
>> provide support for generic clock event support
>> on sparc32.
>>
>> The main focus has been to extend the core functionality
>> (within sparc32) to allow us to share a lot of code between
>> leon and the other platfroms.
>>
>> I have in this process updated a few bits here and there.
>> The patch set is build tested for leon, and
>> runtime tested on my ss5 (sun4m).
>
> I'll test it today on Leon.

Thanks Konrad!
I hope I did not broke it beyond repair :-)

	Sam
