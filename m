From: David Miller <davem@davemloft.net>
Date: Sun, 23 Jul 2017 06:35:31 +0000
Subject: Re: [PATCH 1/3] sparc64: recognize and support sparc M8 cpu type
Message-Id: <20170723.073531.1917446626045297636.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1500536437-14589-1-git-send-email-allen.pais@oracle.com>
In-Reply-To: <1500536437-14589-1-git-send-email-allen.pais@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Allen <allen.pais@oracle.com>
Date: Sat, 22 Jul 2017 14:26:25 +0530

> Sam/David,
>>
>> It is way better than the hardcoded values.
>> If the vales have any sort of name in the sparc specs
>> the values shall be prefixed with this.
>> Otherwise something like
>> CPU_ID_xxx
>>
>> And maybe add an intro comment like this:
>> /* following CPU_ID_xxx constants are used to identify the
>>   * CPU type in the setup phase (see xxx.S)
>> */
>>
> 
> Here's a quick diff. Let me know if this looks good to you guys. I'll
> send out the patch. I have tested this on a T4.

Acked-by: David S. Miller <davem@davemloft.net>
