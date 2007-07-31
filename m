From: gavin duley <gduley@une.edu.au>
Date: Tue, 31 Jul 2007 10:28:54 +0000
Subject: Re: [sparc64] Strange interaction between 2.6 kernel and 2.5 (and 2.6) glibc
Message-Id: <BEE62020-2C94-4E31-A200-1E3C9A3863BD@une.edu.au>
List-Id: <sparclinux.vger.kernel.org>
References: <46933AE8.1080509@systella.fr>
In-Reply-To: <46933AE8.1080509@systella.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 31 Jul 2007, at 19:21, David Miller wrote:

> From: gavin duley <gduley@une.edu.au>
> Date: Mon, 30 Jul 2007 09:45:12 +0000
>
>> On Mon, Jul 30, 2007 at 02:22:35AM -0700, David Miller  
>> <davem@davemloft.net> wrote:
>>> From: gavin duley <gduley@une.edu.au>
>>> Date: Mon, 30 Jul 2007 09:16:53 +0000
>>>
>>>> My Sun box is a Sun Ultra 5 with just one processor: a TI  
>>>> UltraSparc
>>>> IIi (Sabre). From memory, it is 333MHz with 2MB cache.
>>>
>>> What exactly is your test case that fails?
>>
>> The application that hangs on my machine is iceweasel. The machine is
>> running Debian testing:
>
> So I installed debian/testing on my ultra5, and ran iceweasel
> both remotely over SSH and locally under gnome desktop,
> I could get neither to hang.

 From memory, the times iceweasel has hung has generally been after  
it's been running for over a day, though with only a few tabs open.  
Maybe it needs to be left running a little while?

I'm just trying running iceweasel with strace again anyway.

> Now, my ultra5 has a 270MHZ Ultra-IIi compared to your higher
> speed chip, but I'm thinking that the cpu type is a red herring.
>
> I think you guys have something enabled or in use in your
> installations that I don't.
>
> Do you happen to be using NIS, or NFS, or something unique like that?
> If you have some firewalling enabled, can you retest with it disabled?

I'm not using NFS or NIS. At the moment, I don't have a firewall on  
that machine (something I should fix soon, but it's only accessible  
to people on the same network as me so it's not a major priority).  
It's just running a fairly standard install of Debian testing. The  
only slightly unusual thing is that I am using lvm, but I don't think  
that's the problem.

Network-wise, everything is fairly standard, with the IP address  
being got via DHCP.

gavin,

--
You can't go around building a better world for people. Only people
can build a better world for people. Otherwise it's just a cage.
                 -- Terry Pratchett, Witches Abroad

Gavin Duley
<gduley@une.edu.au>   <gduley@turing.une.edu.au>
http://www-personal.une.edu.au/~gduley/


