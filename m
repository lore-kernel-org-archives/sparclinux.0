From: Alexandre Chartre <alexandre.chartre@oracle.com>
Date: Fri, 08 Dec 2017 08:17:55 +0000
Subject: Re: [PATCH] sparc64: Expose mdesc to sysfs
Message-Id: <0bee109a-8463-3029-c833-237cc24c4643@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <201709160508.v8G58BRq011742@aserv0022.oracle.com>
In-Reply-To: <201709160508.v8G58BRq011742@aserv0022.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


On 12/07/2017 07:05 PM, David Miller wrote:
> From: Eric Saint Etienne <eric.saint.etienne@oracle.com>
> Date: Thu, 7 Dec 2017 16:40:14 +0000
>
>>> Can you please provide me with an example of an actual mdesc
>>> entry that needs sanitization? I believe you are thinking of
>>> passwords and crypto keys but I couldn't find any such entry
>>> on any machine I have access to.
>>
>> Dave, I still have to read from you on this.
>
> I don't know, but based upon private communication we received from
> Greg Onufer some might exist.
>
> Please do a detailed audit of the mdesc properties that might contain
> passwords or other sensitive issues, and please provide the results
> of your audit on the list here.
>

FYI, on Solaris, when dumping /dev/mdesc, Solaris filters out the "security-password"
property from the "variables" node, and the "keystore" node.

- "security-password" holds the OBP password if it is set
- "keystore" holds security keys.

alex.
