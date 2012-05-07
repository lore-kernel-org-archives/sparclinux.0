From: Julian Calaby <julian.calaby@gmail.com>
Date: Mon, 07 May 2012 23:19:21 +0000
Subject: Re: sparc sun4c support - time to drop it?
Message-Id: <CAGRGNgUaKP79xKyyQhUrfYUmrTDm5kboHwDpJwAhd5s4t=v=-g@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20120505162104.GA14563@merkur.ravnborg.org>
In-Reply-To: <20120505162104.GA14563@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi David,

On Tue, May 8, 2012 at 9:16 AM, David Miller <davem@davemloft.net> wrote:
> From: Julian Calaby <julian.calaby@gmail.com>
> Date: Tue, 8 May 2012 09:07:34 +1000
>
>> Would it be possible to hide sun4c away behind a kconfig variable
>> that is marked as BROKEN with a entry in the feature-removal file?
>>
>> Or is that just too much work for code which has been broken for a long time.
>
> We just want to kill all of this code off, there is zero value keeping
> it around at all.
>
> It's in the revision history if you just want to look at it, and
> nobody is going to make changes that try to keep it working so letting
> this stuff linger has zero value.

I figured that would be the consensus.

I have no objection to annihilating the code - I just don't like
seeing code being thrown away.

Thanks,

-- 
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
.Plan: http://sites.google.com/site/juliancalaby/
