From: Elad Lahav <elahav@uwaterloo.ca>
Date: Sat, 13 Sep 2008 00:47:24 +0000
Subject: Re: Processor IDs on the Niagara
Message-Id: <48CB0D9C.10901@uwaterloo.ca>
List-Id: <sparclinux.vger.kernel.org>
References: <48CADADA.7050604@uwaterloo.ca>
In-Reply-To: <48CADADA.7050604@uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> The kernel treats core_id=0 as special, therefore we start the
> indexes there at "1".
> 
> The kernel treats proc_id=-1 as special, therefore we start those
> indexes at "0".

My problem was not with the indexing, but rather with the meaning of 
proc_id. It's neither the physical processor ID, nor the virtual 
processor ID. It's just a one-to-one mapping of the core ID. As the 
virtual processor ID is the same as the kernel's CPU ID, I think that 
proc_id should hold the physical processor ID. If not, than this 
information should be kept in some other field of cpu_data.

Elad

