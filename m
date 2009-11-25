From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 25 Nov 2009 01:33:33 +0000
Subject: Re: [PATCH v2 11/11] of: unify phandle name in struct device_node
Message-Id: <fa686aa40911241733s4588c6fag4ed56153842dcd83@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20091124215908.559.23998.stgit@angua> <AE8D50AE-03EE-45FC-80EF-376F0836B5CB@kernel.crashing.org>
In-Reply-To: <AE8D50AE-03EE-45FC-80EF-376F0836B5CB@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org, devicetree-discuss@lists.ozlabs.org, sparclinux@vger.kernel.org, microblaze-uclinux@itee.uq.edu.au, benh@kernel.crashing.org, sfr@canb.auug.org.au, davem@davemloft.net, monstr@monstr.eu

On Tue, Nov 24, 2009 at 6:30 PM, Segher Boessenkool
<segher@kernel.crashing.org> wrote:
>> In struct device_node, the phandle is named 'linux_phandle' for PowerPC
>> and MicroBlaze, and 'node' for SPARC. =A0There is no good reason for the
>> difference, it is just an artifact of the code diverging over a couple
>> of years. =A0This patch renames both to simply .phandle.
>>
>> Note: the .node also existed in PowerPC/MicroBlaze, but the only user
>> seems to be arch/powerpc/platforms/powermac/pfunc_core.c. =A0It doesn't
>> look like the assignment between .linux_phandle and .node is
>> significantly different enough to warrant the separate code paths
>> unless ibm,phandle properties actually appear in Apple device trees.
>>
>> I think it is safe to eliminate the old .node property and use
>> linux_phandle everywhere.
>
> =A0^^^^^^^^^^^^ =A0You forgot to update one :-)

Heeheehee.  oops.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
