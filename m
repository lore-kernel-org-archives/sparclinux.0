From: Dave Kleikamp <dave.kleikamp@oracle.com>
Date: Thu, 02 Jan 2014 17:51:21 +0000
Subject: Re: [Resend] [PATCH] Revert "sparc64: Fix __copy_{to,from}_user_inatomic defines."
Message-Id: <52C5A719.7020806@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <52C58DC7.5090009@oracle.com>
In-Reply-To: <52C58DC7.5090009@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 01/02/2014 11:45 AM, David Miller wrote:
> From: Dave Kleikamp <dave.kleikamp@oracle.com>
> Date: Thu, 02 Jan 2014 10:03:19 -0600
> 
>> This reverts commit 145e1c0023585e0e8f6df22316308ec61c5066b2.
>>
>> This commit broke the behavior of __copy_from_user_inatomic when
>> it is only partially successful. Instead of returning the number
>> of bytes not copied, it now returns 1. This translates to the
>> wrong value being returned by iov_iter_copy_from_user_atomic.
>>
>> xfstests generic/246 and LTP writev01 both fail on btrfs and nfs
>> because of this.
>>
>> Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
> 
> I got your first copy and it's properly queued up in patchwork,
> you don't need to send it again, I've just been really busy.

Thanks. I understand. I hope you took time to enjoy the holidays as
well. :-)

Shaggy
