From: Yisheng Xie <xieyisheng1@huawei.com>
Date: Tue, 05 Jun 2018 09:05:27 +0000
Subject: Re: [PATCH v2 21/21] sparc64: use match_string() helper
Message-Id: <0eb48f06-2046-0b5e-4f16-4ebf3bd056b2@huawei.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1527765086-19873-1-git-send-email-xieyisheng1@huawei.com>
 <1527765086-19873-22-git-send-email-xieyisheng1@huawei.com>
 <CAHp75VeM8+pWEx=XNOGAb=Fdh+rh3WOn2i4m7ObhcVdcXKVa3A@mail.gmail.com>
 <6fefc785-b6b7-e24f-2559-76ce70544717@huawei.com>
 <CAHp75Vc-BDtz62zS2_Chi=UgZJw7vvUzJ34CEHd-RCjqnOjBew@mail.gmail.com>
In-Reply-To: <CAHp75Vc-BDtz62zS2_Chi=UgZJw7vvUzJ34CEHd-RCjqnOjBew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Anthony Yznaga <anthony.yznaga@oracle.com>, Pavel Tatashin <pasha.tatashin@oracle.com>, sparclinux@vger.kernel.org

Hi Andy,

On 2018/6/4 18:06, Andy Shevchenko wrote:
> On Mon, Jun 4, 2018 at 4:06 AM, Yisheng Xie <xieyisheng1@huawei.com> wrote:
>> Hi Andy,
>>
>> On 2018/6/1 19:34, Andy Shevchenko wrote:
>>> On Thu, May 31, 2018 at 2:11 PM, Yisheng Xie <xieyisheng1@huawei.com> wrote:
>>>> match_string() returns the index of an array for a matching string,
>>>> which can be used instead of open coded variant.
>>>
>>>> @@ -512,10 +512,9 @@ static unsigned long __init mdesc_cpu_hwcap_list(void)
>>>>                                 break;
>>>>                         }
>>>>                 }
>>>
>>> It seems previous loop also can be replaced.
>>
>> No, because the there is an NULL in the middle of the array hwcaps:
>>  static const char *hwcaps[] = {
>>           "flush", "stbar", "swap", "muldiv", "v9",
>>           "ultra3", "blkinit", "n2",
>>
>>           /* These strings are as they appear in the machine description
>>            * 'hwcap-list' property for cpu nodes.
>>            */
>>           "mul32", "div32", "fsmuld", "v8plus", "popc", "vis", "vis2",
>>           "ASIBlkInit", "fmaf", "vis3", "hpc", "random", "trans", "fjfmau",
>>           "ima", "cspare", "pause", "cbcond", NULL /*reserved for crypto */,
>>           "adp",
>>   };
> 
> Actually you can.
> What you need is to add string literal instead of NULL and make an
> additional condition after match_string() in all users (not to many),
> something like
> 
> i = match_string();
> if (i < 0)
>  ...
> if (BIT(i) = HWCAP_SPARC_CRYPTO) // or !
OK, I get your point.

Thanks
Yisheng
>  ...
> 

