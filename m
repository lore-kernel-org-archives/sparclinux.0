From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 19 Apr 2015 04:13:41 +0000
Subject: Re: sparc64: Build failure due to commit f1600e549b94 (sparc: Make sparc64 use scalable lib/iommu-co
Message-Id: <55332B75.7080103@roeck-us.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20150418.152753.603680048479537950.davem@davemloft.net>	<20150418.154039.772836205352309363.davem@davemloft.net>	<20150418195514.GC18556@oracle.com> <20150418.174115.1706650539865486258.davem@davemloft.net>
In-Reply-To: <20150418.174115.1706650539865486258.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>, sowmini.varadhan@oracle.com
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

On 04/18/2015 02:41 PM, David Miller wrote:
> From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
> Date: Sat, 18 Apr 2015 15:55:14 -0400
>
>>>
>>> Sowmini, I think I sorted this out in the 'sparc' GIT tree.
>>>
>>> Can you take a look?
>>
>> The patches look right now. These are the commit-ids I checked
>>
>>    ff7d37a502022149655c18035b99a53391be0383
>>    bb620c3d3925aec0ed4f21010c86df08ec18a8c7
>>    0ae53ed15d9b87b883b593a9884957cfa4fc2480
>
> Thanks for checking, I'll get this to Linus ASAP.
>
Latest upstream (v4.0-8110-g64fb1d0) passes my tests.

Guenter

