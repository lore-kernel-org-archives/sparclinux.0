From: Eric Sandeen <sandeen@sandeen.net>
Date: Fri, 02 Jun 2017 03:34:37 +0000
Subject: Re: [sparc64] crc32c misbehave
Message-Id: <a4400f52-5b16-4cd5-1067-9984e8d21dc6@sandeen.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20170601.174419.2151404855471358626.davem@davemloft.net>
 <20170601.215711.1719799806113363582.davem@davemloft.net>
 <9902b59c-0f73-f306-28e0-fea7ee4a1169@sandeen.net>
 <20170601.233329.698047529665811283.davem@davemloft.net>
In-Reply-To: <20170601.233329.698047529665811283.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: matorola@gmail.com, sparclinux@vger.kernel.org, linux-xfs@vger.kernel.org



On 6/1/17 10:33 PM, David Miller wrote:
> From: Eric Sandeen <sandeen@sandeen.net>
> Date: Thu, 1 Jun 2017 21:10:50 -0500
> 
>> On ARM, there was a gcc bug causing similar results - I /think/
>> it was https://gcc.gnu.org/bugzilla/show_bug.cgi?idc293
>>
>> "programs could fail sporadically with this if an interrupt happens at
>> the wrong instant in time and data was written onto the current stack."
>>
>> https://gcc.gnu.org/ml/gcc-patches/2014-09/msg02292.html
>>
>> Maybe totally unrelated; if not, hope it helps.  :)
> 
> Wow, that looks exactly like what the bug is:

Sweet.

\o/

-Eric
