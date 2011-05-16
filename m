From: David Miller <davem@davemloft.net>
Date: Mon, 16 May 2011 15:10:51 +0000
Subject: Re: [PATCH] sparc: add {read,write}*_be routines
Message-Id: <20110516.111051.2030227501627112630.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1305105213-31675-1-git-send-email-jan@gaisler.com>
In-Reply-To: <1305105213-31675-1-git-send-email-jan@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Jan Andersson <jan@gaisler.com>
Date: Mon, 16 May 2011 09:57:28 +0200

> On 05/12/2011 10:45 PM, David Miller wrote:
>> From: Jan Andersson <jan@gaisler.com>
>> Date: Wed, 11 May 2011 11:13:33 +0200
>> 
>>> This patch adds {read,write}*_be big endian memory access
>>> routines to the io.h header used on SPARC32 and SPARC64.
>>>
>>> Tested on SPARC32 (LEON)
>>>
>>> Signed-off-by: Jan Andersson <jan@gaisler.com>
>> 
>> Applied, thanks Jan.
> 
> Thanks David. Will this show up in sparc-next? Any chance that you could
> update the tree on kernel.org? I was asked to provide identification of
> the commit so that it could be merged into usb-next - in order for me to
> get another patchset accepted.

It's now pushed to sparc-2.6
