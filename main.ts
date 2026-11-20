import { readFile, mkdir, writeFile } from 'node:fs/promises';
import { dirname, join } from 'node:path';
import { fileURLToPath } from 'node:url';

const here = dirname(fileURLToPath(import.meta.url));
const input = join(here, 'VIDEO.json');
const parsed: unknown = JSON.parse(await readFile(input, 'utf8'));
if (!parsed || typeof parsed !== 'object' || Array.isArray(parsed) || typeof (parsed as { url?: unknown }).url !== 'string') {
  throw new Error('VIDEO.json must be an object with a string url');
}
const output = JSON.stringify({ url: (parsed as { url: string }).url }) + '\n';
await mkdir('/output', { recursive: true });
await writeFile('/output/VIDEO.json', output, 'utf8');
