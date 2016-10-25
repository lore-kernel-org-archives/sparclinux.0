From: James Clarke <jrtc27@jrtc27.com>
Date: Tue, 25 Oct 2016 17:09:12 +0000
Subject: Re: NMI watchdog: BUG: soft lockup
Message-Id: <0C264FBF-2B0F-4203-840A-8CD3490C26FF@jrtc27.com>
List-Id: <sparclinux.vger.kernel.org>
References: <60822DF7-477D-433C-85AA-FE04D1D4B7B0@jrtc27.com>
In-Reply-To: <60822DF7-477D-433C-85AA-FE04D1D4B7B0@jrtc27.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: sparclinux@vger.kernel.org

> On 25 Oct 2016, at 18:04, David Miller <davem@davemloft.net> wrote:
> 
> From: James Clarke <jrtc27@jrtc27.com>
> Date: Tue, 25 Oct 2016 16:59:04 +0100
> 
>> That’s basically the same as my patch, except this potentially flushes things
>> outside [start, end) if they’re not on 2^22-byte boundaries.
> 
> Oh yes, I see, thanks for pointing that out.
> 
> We have to take the index into account for the purposes of virtual
> address comparison.

I don’t quite follow what you’re trying to say here? idx is only used to index the TSB.

James

