From: Chen Gang <gang.chen@asianux.com>
Date: Wed, 19 Jun 2013 09:24:20 +0000
Subject: Re: [PATCH] arch: sparc: prom: looping issue, need additional length check in the outside looping
Message-Id: <51C178C4.7030400@asianux.com>
List-Id: <sparclinux.vger.kernel.org>
References: <51A6C8FA.3080408@asianux.com> <20130619.021342.853193458609177361.davem@davemloft.net>
In-Reply-To: <20130619.021342.853193458609177361.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, sam@ravnborg.org, sparclinux@vger.kernel.org

On 06/19/2013 05:13 PM, David Miller wrote:
> From: Chen Gang <gang.chen@asianux.com>
> Date: Thu, 30 May 2013 11:35:22 +0800
> 
>>
>> When "cp >= barg_buf + BARG_LEN-2", it breaks internel looping 'while',
>> but outside loop 'for' still has effect, so "*cp++ = ' '" will continue
>> repeating which may cause memory overflow.
>>
>> So need additional length check for it in the outside looping.
>>
>> Also beautify the related code which found by "./scripts/checkpatch.pl"
> 
> Applied.
> 
> 

Thank you very much.


-- 
Chen Gang

Asianux Corporation
