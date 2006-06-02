From: Daniel Smolik <marvin@mydatex.cz>
Date: Fri, 02 Jun 2006 20:18:29 +0000
Subject: Re: [PATCH]: Fix D-cache corruption in mremap()
Message-Id: <44809D15.9000204@mydatex.cz>
List-Id: <sparclinux.vger.kernel.org>
References: <20060601.175258.41634623.davem@davemloft.net>
In-Reply-To: <20060601.175258.41634623.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David Miller napsal(a):
> From: "Christian Joensson" <christian.joensson@gmail.com>
> Date: Fri, 2 Jun 2006 10:04:29 +0200
> 
> 
>>On 6/2/06, David Miller <davem@davemloft.net> wrote:
>>
>>>From: David Miller <davem@davemloft.net>
>>>Date: Thu, 01 Jun 2006 17:52:58 -0700 (PDT)
>>>
>>>
>>>>I'll also post a little reproducer program that can be used to
>>>>accurately see if the patch really fixes the problem on your
>>>>machine or not, which should help with the variability of the
>>>>dpkg corruption case.

May be OK on my E250 ? mmremap stress program never returns is it ok ?
Problem with dselect is solved. In wich version of kernel will be 
patch included ?

			Many thanks
					Dan
