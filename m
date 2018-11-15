From: David Miller <davem@davemloft.net>
Date: Thu, 15 Nov 2018 18:05:14 +0000
Subject: Re: [PATCH] arch/sparc: Use kzalloc_node
Message-Id: <20181115.100514.102337102967411094.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <5bdd3128.1c69fb81.4bd46.f7ce@mx.google.com>
        <CAJr6mf0GLRQiu-FBjQfWmvJsAPQLsY8XH_aacgHUmxz=yts-Wg@mail.gmail.com>
In-Reply-To: <CAJr6mf0GLRQiu-FBjQfWmvJsAPQLsY8XH_aacgHUmxz=yts-Wg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sabyasachi.linux@gmail.com
Cc: khandual@linux.vnet.ibm.com, jrdr.linux@gmail.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, brajeswar.linux@gmail.com

From: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Date: Thu, 15 Nov 2018 23:23:42 +0530

> On Sat, Nov 3, 2018 at 10:54 AM Sabyasachi Gupta
> <sabyasachi.linux@gmail.com> wrote:
>>
>> Replaced kmalloc_node + memset with kzalloc_node
>>
>> Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
> 
> Any comment on this patch?

Just too busy to get to it and am at plumbers this week.

Will try to look at it next week.
