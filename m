From: =?ISO-8859-1?Q?BERTRAND_Jo=EBl?= <joel.bertrand@systella.fr>
Date: Sat, 21 Jul 2007 08:45:22 +0000
Subject: Re: Problems with IceWeasel
Message-Id: <46A1C7A2.10307@systella.fr>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

gavin duley wrote:
> On 20 Jul 2007, at 17:41, gavin duley wrote:
> 
>> Hello,
>>
>> I'm not certain if this is a bug with some package, or whether it's just
>> something odd on my machine, but IceWeasel hasn't been working for me
>> for a few days. I'm running Debian testing on a Sun Ultra 5.
> 
> Looks like debian-sparc was not the right place to ask this particular 
> question. At first I thought it might be sparc specific, but I don't 
> think so any more. I'll try asking on debian-user later if I get a chance.

	It is a bug with futex (only occurs with POSIX threads support and 
glibc 2.5 or 2.6). I have inform David Miller, but I don't know if he 
has found a solution. I have seen that a minor bug in futex has been 
fixed on git, but I haven't tested.

	I have only seen this bug on U60 and U80, never on U2, and few programs 
hang (iceape [and all softwares from seamonkey suite], clamd, bind, 
milter-greylist, mimedefang...).

	Regards,

	JKB
