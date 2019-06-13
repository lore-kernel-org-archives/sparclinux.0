From: David Miller <davem@davemloft.net>
Date: Thu, 13 Jun 2019 22:14:56 +0000
Subject: Re: [PATCH] sparc: Remove redundant copy of the LGPL-2.0
Message-Id: <20190613.151456.1482983218638838740.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20190527163253.27203-1-thuth@redhat.com>
        <20190613.141247.955308190761079084.davem@davemloft.net>
        <CALMQjD-dAX8hU6sNxDWtdxc7CddO3KDd9Fu_J74tZ-6pn5_Z5Q@mail.gmail.com>
In-Reply-To: <CALMQjD-dAX8hU6sNxDWtdxc7CddO3KDd9Fu_J74tZ-6pn5_Z5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: oftedal@gmail.com
Cc: thuth@redhat.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Kjetil Oftedal <oftedal@gmail.com>
Date: Fri, 14 Jun 2019 00:04:28 +0200

> On 13/06/2019, David Miller <davem@davemloft.net> wrote:
>> From: Thomas Huth <thuth@redhat.com>
>> Date: Mon, 27 May 2019 18:32:53 +0200
>>
>>> We already provide the LGPL-2.0 text in LICENSES/preferred/LGPL-2.0,
>>> so there is no need for this additional copy here.
>>>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>
>> Applied.
>>
> 
> Shouldn't the SPDX license identifiers in in arch/sparc/lib be adjusted to
> reflect the original intent of LGPL licensing?

Yes, can someone cook up a quick patch for me for that?

Thanks.
